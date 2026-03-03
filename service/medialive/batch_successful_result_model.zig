/// Details from a successful operation
pub const BatchSuccessfulResultModel = struct {
    /// ARN of the resource
    arn: ?[]const u8 = null,

    /// ID of the resource
    id: ?[]const u8 = null,

    /// Current state of the resource
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .state = "State",
    };
};
