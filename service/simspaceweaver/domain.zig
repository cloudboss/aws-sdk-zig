const LifecycleManagementStrategy = @import("lifecycle_management_strategy.zig").LifecycleManagementStrategy;

/// A collection of app instances that run the same executable app code and have
/// the same
/// launch options and commands.
///
/// For more information about domains, see [Key concepts:
/// Domains](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/what-is_key-concepts.html#what-is_key-concepts_domains)
/// in the *SimSpace Weaver User Guide*.
pub const Domain = struct {
    /// The type of lifecycle management for apps in the domain. Indicates whether
    /// apps in this
    /// domain are *managed* (SimSpace Weaver starts and stops the apps) or
    /// *unmanaged* (you must start and stop the apps).
    ///
    /// **Lifecycle types**
    ///
    /// * `PerWorker` – Managed: SimSpace Weaver starts one app on each
    /// worker.
    ///
    /// * `BySpatialSubdivision` – Managed: SimSpace Weaver starts one app for
    /// each spatial partition.
    ///
    /// * `ByRequest` – Unmanaged: You use the `StartApp`
    /// API to start the apps and use the `StopApp` API to stop the apps.
    lifecycle: ?LifecycleManagementStrategy = null,

    /// The name of the domain.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle = "Lifecycle",
        .name = "Name",
    };
};
