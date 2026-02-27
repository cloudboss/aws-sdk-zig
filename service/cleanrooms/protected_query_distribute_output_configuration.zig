const ProtectedQueryDistributeOutputConfigurationLocation = @import("protected_query_distribute_output_configuration_location.zig").ProtectedQueryDistributeOutputConfigurationLocation;

/// Specifies the configuration for distributing protected query results to
/// multiple receivers, including S3 and collaboration members.
pub const ProtectedQueryDistributeOutputConfiguration = struct {
    /// A list of locations where you want to distribute the protected query
    /// results. Each location must specify either an S3 destination or a
    /// collaboration member destination.
    ///
    /// You can't specify more than one S3 location.
    ///
    /// You can't specify the query runner's account as a member location.
    ///
    /// You must include either an S3 or member output configuration for each
    /// location, but not both.
    locations: []const ProtectedQueryDistributeOutputConfigurationLocation,

    pub const json_field_names = .{
        .locations = "locations",
    };
};
