const AddOnType = @import("add_on_type.zig").AddOnType;
const AutoSnapshotAddOnRequest = @import("auto_snapshot_add_on_request.zig").AutoSnapshotAddOnRequest;
const StopInstanceOnIdleRequest = @import("stop_instance_on_idle_request.zig").StopInstanceOnIdleRequest;

/// Describes a request to enable, modify, or disable an add-on for an Amazon
/// Lightsail
/// resource.
///
/// An additional cost may be associated with enabling add-ons. For more
/// information, see
/// the [Lightsail pricing
/// page](https://aws.amazon.com/lightsail/pricing/).
pub const AddOnRequest = struct {
    /// The add-on type.
    add_on_type: AddOnType,

    /// An object that represents additional parameters when enabling or modifying
    /// the automatic
    /// snapshot add-on.
    auto_snapshot_add_on_request: ?AutoSnapshotAddOnRequest,

    /// An object that represents additional parameters when enabling or modifying
    /// the
    /// `StopInstanceOnIdle` add-on.
    ///
    /// This object only applies to Lightsail for Research resources.
    stop_instance_on_idle_request: ?StopInstanceOnIdleRequest,

    pub const json_field_names = .{
        .add_on_type = "addOnType",
        .auto_snapshot_add_on_request = "autoSnapshotAddOnRequest",
        .stop_instance_on_idle_request = "stopInstanceOnIdleRequest",
    };
};
