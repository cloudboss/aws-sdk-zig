const std = @import("std");

pub const RecommendationSource = enum {
    aws_config,
    compute_optimizer,
    cost_explorer,
    lse,
    manual,
    pse,
    rds,
    resilience,
    resilience_hub,
    security_hub,
    stir,
    ta_check,
    well_architected,
    cost_optimization_hub,

    pub const json_field_names = .{
        .aws_config = "aws_config",
        .compute_optimizer = "compute_optimizer",
        .cost_explorer = "cost_explorer",
        .lse = "lse",
        .manual = "manual",
        .pse = "pse",
        .rds = "rds",
        .resilience = "resilience",
        .resilience_hub = "resilience_hub",
        .security_hub = "security_hub",
        .stir = "stir",
        .ta_check = "ta_check",
        .well_architected = "well_architected",
        .cost_optimization_hub = "cost_optimization_hub",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_config => "aws_config",
            .compute_optimizer => "compute_optimizer",
            .cost_explorer => "cost_explorer",
            .lse => "lse",
            .manual => "manual",
            .pse => "pse",
            .rds => "rds",
            .resilience => "resilience",
            .resilience_hub => "resilience_hub",
            .security_hub => "security_hub",
            .stir => "stir",
            .ta_check => "ta_check",
            .well_architected => "well_architected",
            .cost_optimization_hub => "cost_optimization_hub",
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
