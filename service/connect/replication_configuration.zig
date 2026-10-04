const ReplicationStatusSummary = @import("replication_status_summary.zig").ReplicationStatusSummary;

/// Details about the status of the replication of a source Connect Customer
/// instance across Amazon Web Services
/// Regions. Use these details to understand the general status of a given
/// replication. For information about why a
/// replication process may fail, see [Why a
/// ReplicateInstance call
/// fails](https://docs.aws.amazon.com/connect/latest/adminguide/create-replica-connect-instance.html#why-replicateinstance-fails) in the *Create a replica of your existing Connect Customer
/// instance* topic in the *Connect Customer Administrator Guide*.
pub const ReplicationConfiguration = struct {
    /// The URL that is used to sign-in to your Connect Customer instance according
    /// to your traffic distribution group
    /// configuration. For more information about sign-in and traffic distribution
    /// groups, see [Important things to
    /// know](https://docs.aws.amazon.com/connect/latest/adminguide/setup-traffic-distribution-groups.html) in the
    /// *Create traffic distribution groups* topic in the *Connect Customer
    /// Administrator
    /// Guide*.
    global_sign_in_endpoint: ?[]const u8 = null,

    /// A list of replication status summaries. The summaries contain details about
    /// the replication of configuration
    /// information for Connect Customer resources, for each Amazon Web Services
    /// Region.
    replication_status_summary_list: ?[]const ReplicationStatusSummary = null,

    /// The Amazon Web Services Region where the source Connect Customer instance
    /// was created. This is the Region where
    /// the
    /// [ReplicateInstance](https://docs.aws.amazon.com/connect/latest/APIReference/API_ReplicateInstance.html) API was called to start the replication process.
    source_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .global_sign_in_endpoint = "GlobalSignInEndpoint",
        .replication_status_summary_list = "ReplicationStatusSummaryList",
        .source_region = "SourceRegion",
    };
};
