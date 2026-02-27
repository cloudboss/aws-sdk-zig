const FaceDetail = @import("face_detail.zig").FaceDetail;

/// Contains data regarding the input face used for a search.
pub const SearchedFaceDetails = struct {
    face_detail: ?FaceDetail,

    pub const json_field_names = .{
        .face_detail = "FaceDetail",
    };
};
