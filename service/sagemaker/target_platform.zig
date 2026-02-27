const TargetPlatformAccelerator = @import("target_platform_accelerator.zig").TargetPlatformAccelerator;
const TargetPlatformArch = @import("target_platform_arch.zig").TargetPlatformArch;
const TargetPlatformOs = @import("target_platform_os.zig").TargetPlatformOs;

/// Contains information about a target platform that you want your model to run
/// on, such as OS, architecture, and accelerators. It is an alternative of
/// `TargetDevice`.
pub const TargetPlatform = struct {
    /// Specifies a target platform accelerator (optional).
    ///
    /// * `NVIDIA`: Nvidia graphics processing unit. It also requires `gpu-code`,
    ///   `trt-ver`, `cuda-ver` compiler options
    /// * `MALI`: ARM Mali graphics processor
    /// * `INTEL_GRAPHICS`: Integrated Intel graphics
    accelerator: ?TargetPlatformAccelerator,

    /// Specifies a target platform architecture.
    ///
    /// * `X86_64`: 64-bit version of the x86 instruction set.
    /// * `X86`: 32-bit version of the x86 instruction set.
    /// * `ARM64`: ARMv8 64-bit CPU.
    /// * `ARM_EABIHF`: ARMv7 32-bit, Hard Float.
    /// * `ARM_EABI`: ARMv7 32-bit, Soft Float. Used by Android 32-bit ARM platform.
    arch: TargetPlatformArch,

    /// Specifies a target platform OS.
    ///
    /// * `LINUX`: Linux-based operating systems.
    /// * `ANDROID`: Android operating systems. Android API level can be specified
    ///   using the `ANDROID_PLATFORM` compiler option. For example,
    ///   `"CompilerOptions": {'ANDROID_PLATFORM': 28}`
    os: TargetPlatformOs,

    pub const json_field_names = .{
        .accelerator = "Accelerator",
        .arch = "Arch",
        .os = "Os",
    };
};
