const SyncBlocker = @import("sync_blocker.zig").SyncBlocker;

/// If a service instance is manually updated, Proton wants to prevent
/// accidentally overriding
/// a manual change.
///
/// A blocker is created because of the manual update or deletion of a service
/// instance. The
/// summary describes the blocker as being active or resolved.
pub const ServiceSyncBlockerSummary = struct {
    /// The latest active blockers for the synced service.
    latest_blockers: ?[]const SyncBlocker,

    /// The name of the service instance that you want sync your service
    /// configuration
    /// with.
    service_instance_name: ?[]const u8,

    /// The name of the service that you want to get the sync blocker summary for.
    /// If given a
    /// service instance name and a service name, it will return the blockers only
    /// applying to the
    /// instance that is blocked.
    ///
    /// If given only a service name, it will return the blockers that apply to all
    /// of the
    /// instances. In order to get the blockers for a single instance, you will need
    /// to make two
    /// distinct calls, one to get the sync blocker summary for the service and the
    /// other to get the
    /// sync blocker for the service instance.
    service_name: []const u8,

    pub const json_field_names = .{
        .latest_blockers = "latestBlockers",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};
