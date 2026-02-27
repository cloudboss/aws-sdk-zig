const Criticality = @import("criticality.zig").Criticality;

/// Object that determines whether tracking should be used during a contact
/// executed with this `Config` in the mission profile.
pub const TrackingConfig = struct {
    /// Current setting for autotrack.
    autotrack: Criticality,

    pub const json_field_names = .{
        .autotrack = "autotrack",
    };
};
