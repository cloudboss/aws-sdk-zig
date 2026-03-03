const std = @import("std");

pub const APIName = enum {
    put_media,
    get_media,
    list_fragments,
    get_media_for_fragment_list,
    get_hls_streaming_session_url,
    get_dash_streaming_session_url,
    get_clip,
    get_images,

    pub const json_field_names = .{
        .put_media = "PUT_MEDIA",
        .get_media = "GET_MEDIA",
        .list_fragments = "LIST_FRAGMENTS",
        .get_media_for_fragment_list = "GET_MEDIA_FOR_FRAGMENT_LIST",
        .get_hls_streaming_session_url = "GET_HLS_STREAMING_SESSION_URL",
        .get_dash_streaming_session_url = "GET_DASH_STREAMING_SESSION_URL",
        .get_clip = "GET_CLIP",
        .get_images = "GET_IMAGES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .put_media => "PUT_MEDIA",
            .get_media => "GET_MEDIA",
            .list_fragments => "LIST_FRAGMENTS",
            .get_media_for_fragment_list => "GET_MEDIA_FOR_FRAGMENT_LIST",
            .get_hls_streaming_session_url => "GET_HLS_STREAMING_SESSION_URL",
            .get_dash_streaming_session_url => "GET_DASH_STREAMING_SESSION_URL",
            .get_clip => "GET_CLIP",
            .get_images => "GET_IMAGES",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
