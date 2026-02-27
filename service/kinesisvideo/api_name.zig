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
};
