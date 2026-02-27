const SummarizedAttackVector = @import("summarized_attack_vector.zig").SummarizedAttackVector;
const SummarizedCounter = @import("summarized_counter.zig").SummarizedCounter;
const SubResourceType = @import("sub_resource_type.zig").SubResourceType;

/// The attack information for the specified SubResource.
pub const SubResourceSummary = struct {
    /// The list of attack types and associated counters.
    attack_vectors: ?[]const SummarizedAttackVector,

    /// The counters that describe the details of the attack.
    counters: ?[]const SummarizedCounter,

    /// The unique identifier (ID) of the `SubResource`.
    id: ?[]const u8,

    /// The `SubResource` type.
    type: ?SubResourceType,

    pub const json_field_names = .{
        .attack_vectors = "AttackVectors",
        .counters = "Counters",
        .id = "Id",
        .type = "Type",
    };
};
