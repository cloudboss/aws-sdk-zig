const ProtectedQueryDistributeOutput = @import("protected_query_distribute_output.zig").ProtectedQueryDistributeOutput;
const ProtectedQuerySingleMemberOutput = @import("protected_query_single_member_output.zig").ProtectedQuerySingleMemberOutput;
const ProtectedQueryS3Output = @import("protected_query_s3_output.zig").ProtectedQueryS3Output;

/// Contains details about the protected query output.
pub const ProtectedQueryOutput = union(enum) {
    /// Contains output information for protected queries that use a `distribute`
    /// output type. This output type lets you send query results to multiple
    /// locations - either to S3 or to collaboration members.
    ///
    /// You can only use the `distribute` output type with the Spark analytics
    /// engine.
    distribute: ?ProtectedQueryDistributeOutput,
    /// The list of member Amazon Web Services account(s) that received the results
    /// of the query.
    member_list: ?[]const ProtectedQuerySingleMemberOutput,
    /// If present, the output for a protected query with an `S3` output type.
    s_3: ?ProtectedQueryS3Output,

    pub const json_field_names = .{
        .distribute = "distribute",
        .member_list = "memberList",
        .s_3 = "s3",
    };
};
