const IamInstanceProfile = @import("iam_instance_profile.zig").IamInstanceProfile;
const IamInstanceProfileAssociationState = @import("iam_instance_profile_association_state.zig").IamInstanceProfileAssociationState;

/// Describes an association between an IAM instance profile and an instance.
pub const IamInstanceProfileAssociation = struct {
    /// The ID of the association.
    association_id: ?[]const u8,

    /// The IAM instance profile.
    iam_instance_profile: ?IamInstanceProfile,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The state of the association.
    state: ?IamInstanceProfileAssociationState,

    /// The time the IAM instance profile was associated with the instance.
    timestamp: ?i64,
};
