const MembershipProtectedQueryOutputConfiguration = @import("membership_protected_query_output_configuration.zig").MembershipProtectedQueryOutputConfiguration;

/// Contains configurations for protected query results.
pub const MembershipProtectedQueryResultConfiguration = struct {
    /// Configuration for protected query results.
    output_configuration: MembershipProtectedQueryOutputConfiguration,

    /// The unique ARN for an IAM role that is used by Clean Rooms to write
    /// protected query results to the result location, given by the member who can
    /// receive results.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
        .role_arn = "roleArn",
    };
};
