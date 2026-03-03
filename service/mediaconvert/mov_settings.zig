const MovClapAtom = @import("mov_clap_atom.zig").MovClapAtom;
const MovCslgAtom = @import("mov_cslg_atom.zig").MovCslgAtom;
const MovMpeg2FourCCControl = @import("mov_mpeg_2_four_cc_control.zig").MovMpeg2FourCCControl;
const MovPaddingControl = @import("mov_padding_control.zig").MovPaddingControl;
const MovReference = @import("mov_reference.zig").MovReference;

/// These settings relate to your QuickTime MOV output container.
pub const MovSettings = struct {
    /// When enabled, include 'clap' atom if appropriate for the video output
    /// settings.
    clap_atom: ?MovClapAtom = null,

    /// When enabled, file composition times will start at zero, composition times
    /// in the 'ctts' (composition time to sample) box for B-frames will be
    /// negative, and a 'cslg' (composition shift least greatest) box will be
    /// included per 14496-1 amendment 1. This improves compatibility with Apple
    /// players and tools.
    cslg_atom: ?MovCslgAtom = null,

    /// When set to XDCAM, writes MPEG2 video streams into the QuickTime file using
    /// XDCAM fourcc codes. This increases compatibility with Apple editors and
    /// players, but may decrease compatibility with other players. Only applicable
    /// when the video codec is MPEG2.
    mpeg_2_four_cc_control: ?MovMpeg2FourCCControl = null,

    /// Unless you need Omneon compatibility: Keep the default value, None. To make
    /// this output compatible with Omneon: Choose Omneon. When you do, MediaConvert
    /// increases the length of the 'elst' edit list atom. Note that this might
    /// cause file rejections when a recipient of the output file doesn't expect
    /// this extra padding.
    padding_control: ?MovPaddingControl = null,

    /// Always keep the default value (SELF_CONTAINED) for this setting.
    reference: ?MovReference = null,

    pub const json_field_names = .{
        .clap_atom = "ClapAtom",
        .cslg_atom = "CslgAtom",
        .mpeg_2_four_cc_control = "Mpeg2FourCCControl",
        .padding_control = "PaddingControl",
        .reference = "Reference",
    };
};
