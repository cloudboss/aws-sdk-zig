const SummarizedCounter = @import("summarized_counter.zig").SummarizedCounter;

/// A summary of information about the attack.
pub const SummarizedAttackVector = struct {
    /// The list of counters that describe the details of the attack.
    vector_counters: ?[]const SummarizedCounter,

    /// The attack type, for example, SNMP reflection or SYN flood.
    vector_type: []const u8,

    pub const json_field_names = .{
        .vector_counters = "VectorCounters",
        .vector_type = "VectorType",
    };
};
