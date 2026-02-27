/// A custom header for custom request and response handling.
pub const AwsWafv2CustomHttpHeader = struct {
    /// The name of the custom header.
    name: ?[]const u8,

    /// The value of the custom header.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
