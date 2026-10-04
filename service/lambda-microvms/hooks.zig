const MicrovmHooks = @import("microvm_hooks.zig").MicrovmHooks;
const MicrovmImageHooks = @import("microvm_image_hooks.zig").MicrovmImageHooks;

/// Lifecycle hook configuration for MicroVMs and MicroVM images.
pub const Hooks = struct {
    /// The lifecycle hooks for MicroVM events.
    microvm_hooks: ?MicrovmHooks = null,

    /// The hooks for MicroVM image build events.
    microvm_image_hooks: ?MicrovmImageHooks = null,

    /// The port number on which the hooks listener runs.
    port: ?i32 = null,

    pub const json_field_names = .{
        .microvm_hooks = "microvmHooks",
        .microvm_image_hooks = "microvmImageHooks",
        .port = "port",
    };
};
