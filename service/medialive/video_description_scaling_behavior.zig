/// Video Description Scaling Behavior
pub const VideoDescriptionScalingBehavior = enum {
    default,
    stretch_to_output,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
    };
};
