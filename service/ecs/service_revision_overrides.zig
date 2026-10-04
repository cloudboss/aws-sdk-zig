const RuntimePlatformOverride = @import("runtime_platform_override.zig").RuntimePlatformOverride;

/// Contains the runtime overrides that Amazon ECS automatically applies to a
/// service revision when the effective runtime configuration differs from the
/// task definition. This value is read-only.
pub const ServiceRevisionOverrides = struct {
    /// The runtime platform override that Amazon ECS automatically applies to the
    /// service revision. You can't set this value.
    runtime_platform: ?RuntimePlatformOverride = null,

    pub const json_field_names = .{
        .runtime_platform = "runtimePlatform",
    };
};
