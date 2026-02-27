const SsmParameterDataType = @import("ssm_parameter_data_type.zig").SsmParameterDataType;

/// Configuration for a single Parameter in the Amazon Web Services Systems
/// Manager (SSM) Parameter Store in
/// a given Region.
pub const SsmParameterConfiguration = struct {
    /// Specify the account that will own the Parameter in a given Region. During
    /// distribution,
    /// this account must be specified in distribution settings as a target account
    /// for the
    /// Region.
    ami_account_id: ?[]const u8,

    /// The data type specifies what type of value the Parameter contains. We
    /// recommend that
    /// you use data type `aws:ec2:image`.
    data_type: ?SsmParameterDataType,

    /// This is the name of the Parameter in the target Region or account. The image
    /// distribution creates the Parameter if it doesn't already exist. Otherwise,
    /// it updates
    /// the parameter.
    parameter_name: []const u8,

    pub const json_field_names = .{
        .ami_account_id = "amiAccountId",
        .data_type = "dataType",
        .parameter_name = "parameterName",
    };
};
