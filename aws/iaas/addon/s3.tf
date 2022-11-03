locals {
    merged_s3 = merge(var.s3, {
        format("%s-velero-s3-registry", var.eks.cluster_id) = {
            "${local.block_public_acls}"         = true
            "${local.block_public_policy}"       = true
            "${local.ignore_public_acls}"        = true
            "${local.restrict_public_buckets}"   = true
        }
    })
    block_public_acls = "block_public_acls"
    block_public_policy = "block_public_policy"
    ignore_public_acls = "ignore_public_acls"
    restrict_public_buckets = "restrict_public_buckets"
    merged_s3_keys = keys(local.merged_s3)
}

resource "aws_s3_bucket" "zcp" {
    count = var.s3_count
    bucket = lower("${local.merged_s3[local.merged_s3_keys[count.index]]}")
}

resource "aws_s3_bucket_public_access_block" "zcp" {
    depends_on = [
      aws_s3_bucket.zcp
    ]
    count = var.s3_count
    bucket = aws_s3_bucket.zcp[local.merged_s3[count.index]].id

    block_public_acls       = local.merged_s3[local.merged_s3[count.index]].local.block_public_acls  //   each.value[local.block_public_acls]
    block_public_policy     = local.merged_s3[local.merged_s3[count.index]].local.block_public_policy
    ignore_public_acls      = local.merged_s3[local.merged_s3[count.index]].local.ignore_public_acls
    restrict_public_buckets = local.merged_s3[local.merged_s3[count.index]].local.restrict_public_buckets
}