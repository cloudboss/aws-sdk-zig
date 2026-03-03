const InputLocation = @import("input_location.zig").InputLocation;
const AvailBlankingState = @import("avail_blanking_state.zig").AvailBlankingState;

/// Avail Blanking
pub const AvailBlanking = struct {
    /// Blanking image to be used. Leave empty for solid black. Only bmp and png
    /// images are supported.
    avail_blanking_image: ?InputLocation = null,

    /// When set to enabled, causes video, audio and captions to be blanked when
    /// insertion metadata is added.
    state: ?AvailBlankingState = null,

    pub const json_field_names = .{
        .avail_blanking_image = "AvailBlankingImage",
        .state = "State",
    };
};
