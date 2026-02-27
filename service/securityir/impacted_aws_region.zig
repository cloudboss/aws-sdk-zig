const AwsRegion = @import("aws_region.zig").AwsRegion;

pub const ImpactedAwsRegion = struct {
    region: AwsRegion,

    pub const json_field_names = .{
        .region = "region",
    };
};
