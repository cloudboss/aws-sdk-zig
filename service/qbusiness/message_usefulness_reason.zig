const std = @import("std");

pub const MessageUsefulnessReason = enum {
    not_factually_correct,
    harmful_or_unsafe,
    incorrect_or_missing_sources,
    not_helpful,
    factually_correct,
    complete,
    relevant_sources,
    helpful,
    not_based_on_documents,
    not_complete,
    not_concise,
    other,

    pub const json_field_names = .{
        .not_factually_correct = "NOT_FACTUALLY_CORRECT",
        .harmful_or_unsafe = "HARMFUL_OR_UNSAFE",
        .incorrect_or_missing_sources = "INCORRECT_OR_MISSING_SOURCES",
        .not_helpful = "NOT_HELPFUL",
        .factually_correct = "FACTUALLY_CORRECT",
        .complete = "COMPLETE",
        .relevant_sources = "RELEVANT_SOURCES",
        .helpful = "HELPFUL",
        .not_based_on_documents = "NOT_BASED_ON_DOCUMENTS",
        .not_complete = "NOT_COMPLETE",
        .not_concise = "NOT_CONCISE",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_factually_correct => "NOT_FACTUALLY_CORRECT",
            .harmful_or_unsafe => "HARMFUL_OR_UNSAFE",
            .incorrect_or_missing_sources => "INCORRECT_OR_MISSING_SOURCES",
            .not_helpful => "NOT_HELPFUL",
            .factually_correct => "FACTUALLY_CORRECT",
            .complete => "COMPLETE",
            .relevant_sources => "RELEVANT_SOURCES",
            .helpful => "HELPFUL",
            .not_based_on_documents => "NOT_BASED_ON_DOCUMENTS",
            .not_complete => "NOT_COMPLETE",
            .not_concise => "NOT_CONCISE",
            .other => "OTHER",
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
