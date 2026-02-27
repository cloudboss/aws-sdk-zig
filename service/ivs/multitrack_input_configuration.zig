const MultitrackMaximumResolution = @import("multitrack_maximum_resolution.zig").MultitrackMaximumResolution;
const MultitrackPolicy = @import("multitrack_policy.zig").MultitrackPolicy;

/// A complex type that specifies multitrack input configuration.
pub const MultitrackInputConfiguration = struct {
    /// Indicates whether multitrack input is enabled. Can be set to `true` only if
    /// channel type is `STANDARD`. Setting `enabled` to `true` with any other
    /// channel type will cause an exception. If `true`, then `policy`,
    /// `maximumResolution`, and `containerFormat` are required, and
    /// `containerFormat` must be set to `FRAGMENTED_MP4`. Default: `false`.
    enabled: bool = false,

    /// Maximum resolution for multitrack input. Required if `enabled` is `true`.
    maximum_resolution: ?MultitrackMaximumResolution,

    /// Indicates whether multitrack input is allowed or required. Required if
    /// `enabled` is `true`.
    policy: ?MultitrackPolicy,

    pub const json_field_names = .{
        .enabled = "enabled",
        .maximum_resolution = "maximumResolution",
        .policy = "policy",
    };
};
