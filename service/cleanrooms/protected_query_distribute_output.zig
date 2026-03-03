const ProtectedQuerySingleMemberOutput = @import("protected_query_single_member_output.zig").ProtectedQuerySingleMemberOutput;
const ProtectedQueryS3Output = @import("protected_query_s3_output.zig").ProtectedQueryS3Output;

/// Contains the output information for a protected query with a distribute
/// output configuration.
///
/// This output type allows query results to be distributed to multiple
/// receivers, including S3 and collaboration members. It is only available for
/// queries using the Spark analytics engine.
pub const ProtectedQueryDistributeOutput = struct {
    /// Contains the output results for each member location specified in the
    /// distribute output configuration. Each entry provides details about the
    /// result distribution to a specific collaboration member.
    member_list: ?[]const ProtectedQuerySingleMemberOutput = null,

    s_3: ?ProtectedQueryS3Output = null,

    pub const json_field_names = .{
        .member_list = "memberList",
        .s_3 = "s3",
    };
};
