const ProtectedQueryDistributeOutputConfiguration = @import("protected_query_distribute_output_configuration.zig").ProtectedQueryDistributeOutputConfiguration;
const IntermediateTableOutputConfiguration = @import("intermediate_table_output_configuration.zig").IntermediateTableOutputConfiguration;
const ProtectedQueryMemberOutputConfiguration = @import("protected_query_member_output_configuration.zig").ProtectedQueryMemberOutputConfiguration;
const ProtectedQueryS3OutputConfiguration = @import("protected_query_s3_output_configuration.zig").ProtectedQueryS3OutputConfiguration;

/// Contains configuration details for protected query output.
pub const ProtectedQueryOutputConfiguration = union(enum) {
    /// Required configuration for a protected query with a `distribute` output
    /// type.
    distribute: ?ProtectedQueryDistributeOutputConfiguration,
    /// The intermediate table output configuration, present when the protected
    /// query was triggered by a populate operation.
    intermediate_table: ?IntermediateTableOutputConfiguration,
    /// Required configuration for a protected query with a `member` output type.
    member: ?ProtectedQueryMemberOutputConfiguration,
    /// Required configuration for a protected query with an `s3` output type.
    s_3: ?ProtectedQueryS3OutputConfiguration,

    pub const json_field_names = .{
        .distribute = "distribute",
        .intermediate_table = "intermediateTable",
        .member = "member",
        .s_3 = "s3",
    };
};
