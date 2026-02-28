/// Additional information about the generated finding.
pub const ServiceAdditionalInfo = struct {
    /// Describes the type of the additional information.
    @"type": ?[]const u8,

    /// This field specifies the value of the additional information.
    value: ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
