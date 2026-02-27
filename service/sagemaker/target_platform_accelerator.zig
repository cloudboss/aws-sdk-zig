pub const TargetPlatformAccelerator = enum {
    intel_graphics,
    mali,
    nvidia,
    nna,

    pub const json_field_names = .{
        .intel_graphics = "INTEL_GRAPHICS",
        .mali = "MALI",
        .nvidia = "NVIDIA",
        .nna = "NNA",
    };
};
