const DesiredModality = @import("desired_modality.zig").DesiredModality;

/// Configuration for routing file type to desired modality
pub const ModalityRoutingConfiguration = struct {
    jpeg: ?DesiredModality,

    mov: ?DesiredModality,

    mp_4: ?DesiredModality,

    png: ?DesiredModality,

    pub const json_field_names = .{
        .jpeg = "jpeg",
        .mov = "mov",
        .mp_4 = "mp4",
        .png = "png",
    };
};
