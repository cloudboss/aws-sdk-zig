const FaceDetail = @import("face_detail.zig").FaceDetail;
const UnsearchedFaceReason = @import("unsearched_face_reason.zig").UnsearchedFaceReason;

/// Face details inferred from the image but not used for search. The response
/// attribute
/// contains reasons for why a face wasn't used for Search.
pub const UnsearchedFace = struct {
    face_details: ?FaceDetail,

    /// Reasons why a face wasn't used for Search.
    reasons: ?[]const UnsearchedFaceReason,

    pub const json_field_names = .{
        .face_details = "FaceDetails",
        .reasons = "Reasons",
    };
};
