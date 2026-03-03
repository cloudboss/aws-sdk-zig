const NdiSourceInfo = @import("ndi_source_info.zig").NdiSourceInfo;
const NdiMediaInfo = @import("ndi_media_info.zig").NdiMediaInfo;
const MessageDetail = @import("message_detail.zig").MessageDetail;

/// Comprehensive information about the NDI® source that's associated with a
/// flow. This includes the currently active NDI source, a list of all
/// discovered NDI senders, metadata about the media streams, and any relevant
/// status messages.
pub const NdiSourceMetadataInfo = struct {
    /// The connected NDI sender that's currently sending source content to the
    /// flow's NDI source.
    active_source: ?NdiSourceInfo = null,

    /// A list of the available upstream NDI senders aggregated from all of your
    /// configured discovery servers.
    discovered_sources: []const NdiSourceInfo,

    /// Detailed information about the media streams (video, audio, and so on) that
    /// are part of the active NDI source.
    media_info: NdiMediaInfo,

    /// Any status messages or error codes related to the NDI source and its
    /// metadata.
    messages: []const MessageDetail,

    pub const json_field_names = .{
        .active_source = "ActiveSource",
        .discovered_sources = "DiscoveredSources",
        .media_info = "MediaInfo",
        .messages = "Messages",
    };
};
