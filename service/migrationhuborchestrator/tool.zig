/// List of AWS services utilized in a migration workflow.
pub const Tool = struct {
    /// The name of an AWS service.
    name: ?[]const u8,

    /// The URL of an AWS service.
    url: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .url = "url",
    };
};
