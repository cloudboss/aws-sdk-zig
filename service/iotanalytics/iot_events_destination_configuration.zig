/// Configuration information for delivery of dataset contents to IoT Events.
pub const IotEventsDestinationConfiguration = struct {
    /// The name of the IoT Events input to which dataset contents are delivered.
    input_name: []const u8,

    /// The ARN of the role that grants IoT Analytics permission to deliver dataset
    /// contents to an IoT Events
    /// input.
    role_arn: []const u8,

    pub const json_field_names = .{
        .input_name = "inputName",
        .role_arn = "roleArn",
    };
};
