const AudioDolbyEDecode = @import("audio_dolby_e_decode.zig").AudioDolbyEDecode;
const AudioTrack = @import("audio_track.zig").AudioTrack;

/// Audio Track Selection
pub const AudioTrackSelection = struct {
    /// Configure decoding options for Dolby E streams - these should be Dolby E
    /// frames carried in PCM streams tagged with SMPTE-337
    dolby_e_decode: ?AudioDolbyEDecode = null,

    /// Selects one or more unique audio tracks from within a source.
    tracks: []const AudioTrack,

    pub const json_field_names = .{
        .dolby_e_decode = "DolbyEDecode",
        .tracks = "Tracks",
    };
};
