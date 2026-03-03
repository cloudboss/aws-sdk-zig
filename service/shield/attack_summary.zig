const AttackVectorDescription = @import("attack_vector_description.zig").AttackVectorDescription;

/// Summarizes all DDoS attacks for a specified time period.
pub const AttackSummary = struct {
    /// The unique identifier (ID) of the attack.
    attack_id: ?[]const u8 = null,

    /// The list of attacks for a specified time period.
    attack_vectors: ?[]const AttackVectorDescription = null,

    /// The end time of the attack, in Unix time in seconds.
    end_time: ?i64 = null,

    /// The ARN (Amazon Resource Name) of the resource that was attacked.
    resource_arn: ?[]const u8 = null,

    /// The start time of the attack, in Unix time in seconds.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .attack_id = "AttackId",
        .attack_vectors = "AttackVectors",
        .end_time = "EndTime",
        .resource_arn = "ResourceArn",
        .start_time = "StartTime",
    };
};
