const FormFactor = @import("form_factor.zig").FormFactor;
const OutpostGeneration = @import("outpost_generation.zig").OutpostGeneration;

/// A supported form factor and Outpost generation configuration for an instance
/// type.
pub const FormFactorConfig = struct {
    /// The form factor. Valid values are `RACK` for rack-based Outposts and
    /// `SERVER` for server-based Outposts.
    form_factor: ?FormFactor = null,

    /// The Outpost generation. Valid values are `GENERATION_1` for first-generation
    /// rack deployments and `GENERATION_2` for second-generation rack deployments.
    /// This
    /// value is not set for server form factors.
    outpost_generation: ?OutpostGeneration = null,

    pub const json_field_names = .{
        .form_factor = "FormFactor",
        .outpost_generation = "OutpostGeneration",
    };
};
