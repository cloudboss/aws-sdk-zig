pub const CustomizationTechnique = enum {
    sft,
    dpo,
    rlvr,
    rlaif,

    pub const json_field_names = .{
        .sft = "SFT",
        .dpo = "DPO",
        .rlvr = "RLVR",
        .rlaif = "RLAIF",
    };
};
