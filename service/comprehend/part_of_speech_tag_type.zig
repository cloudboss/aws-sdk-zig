const std = @import("std");

pub const PartOfSpeechTagType = enum {
    adj,
    adp,
    adv,
    aux,
    conj,
    cconj,
    det,
    intj,
    noun,
    num,
    o,
    part,
    pron,
    propn,
    punct,
    sconj,
    sym,
    verb,

    pub const json_field_names = .{
        .adj = "ADJ",
        .adp = "ADP",
        .adv = "ADV",
        .aux = "AUX",
        .conj = "CONJ",
        .cconj = "CCONJ",
        .det = "DET",
        .intj = "INTJ",
        .noun = "NOUN",
        .num = "NUM",
        .o = "O",
        .part = "PART",
        .pron = "PRON",
        .propn = "PROPN",
        .punct = "PUNCT",
        .sconj = "SCONJ",
        .sym = "SYM",
        .verb = "VERB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .adj => "ADJ",
            .adp => "ADP",
            .adv => "ADV",
            .aux => "AUX",
            .conj => "CONJ",
            .cconj => "CCONJ",
            .det => "DET",
            .intj => "INTJ",
            .noun => "NOUN",
            .num => "NUM",
            .o => "O",
            .part => "PART",
            .pron => "PRON",
            .propn => "PROPN",
            .punct => "PUNCT",
            .sconj => "SCONJ",
            .sym => "SYM",
            .verb => "VERB",
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
