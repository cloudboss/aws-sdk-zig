const DesiredModality = @import("desired_modality.zig").DesiredModality;

/// Configuration for routing file type to desired modality
pub const ModalityRoutingConfiguration = struct {
    jpeg: ?DesiredModality = null,

    mov: ?DesiredModality = null,

    mp_4: ?DesiredModality = null,

    png: ?DesiredModality = null,

    pub const json_field_names = .{
        .jpeg = "jpeg",
        .mov = "mov",
        .mp_4 = "mp4",
        .png = "png",
    };
};
