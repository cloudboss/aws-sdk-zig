/// A custom response string that Amazon Lex sends to your application. You
/// define the content and structure the string.
pub const CustomPayload = struct {
    /// The string that is sent to your application.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
