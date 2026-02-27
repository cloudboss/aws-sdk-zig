pub const CpuVendorArchitecture = enum {
    aws_arm64,
    current,

    pub const json_field_names = .{
        .aws_arm64 = "AWS_ARM64",
        .current = "CURRENT",
    };
};
