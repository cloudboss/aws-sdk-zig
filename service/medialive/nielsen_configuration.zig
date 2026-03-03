const NielsenPcmToId3TaggingState = @import("nielsen_pcm_to_id_3_tagging_state.zig").NielsenPcmToId3TaggingState;

/// Nielsen Configuration
pub const NielsenConfiguration = struct {
    /// Enter the Distributor ID assigned to your organization by Nielsen.
    distributor_id: ?[]const u8 = null,

    /// Enables Nielsen PCM to ID3 tagging
    nielsen_pcm_to_id_3_tagging: ?NielsenPcmToId3TaggingState = null,

    pub const json_field_names = .{
        .distributor_id = "DistributorId",
        .nielsen_pcm_to_id_3_tagging = "NielsenPcmToId3Tagging",
    };
};
