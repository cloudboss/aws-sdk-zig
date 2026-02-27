/// Provides information about the CloudFormation stack output.
pub const AwsCloudFormationStackOutputsDetails = struct {
    /// A user-defined description associated with the output.
    description: ?[]const u8,

    /// The key associated with the output.
    output_key: ?[]const u8,

    /// The value associated with the output.
    output_value: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .output_key = "OutputKey",
        .output_value = "OutputValue",
    };
};
