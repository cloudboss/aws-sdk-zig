pub const DestinationCategory = enum {
    intra_az,
    inter_az,
    inter_vpc,
    unclassified,
    amazon_s3,
    amazon_dynamodb,
    inter_region,

    pub const json_field_names = .{
        .intra_az = "INTRA_AZ",
        .inter_az = "INTER_AZ",
        .inter_vpc = "INTER_VPC",
        .unclassified = "UNCLASSIFIED",
        .amazon_s3 = "AMAZON_S3",
        .amazon_dynamodb = "AMAZON_DYNAMODB",
        .inter_region = "INTER_REGION",
    };
};
