pub const ReservedCapacityInstanceType = enum {
    ml_p4_d_24_xlarge,
    ml_p5_48_xlarge,
    ml_p5_e_48_xlarge,
    ml_p5_en_48_xlarge,
    ml_trn1_32_xlarge,
    ml_trn2_48_xlarge,
    ml_p6_b200_48_xlarge,
    ml_p4_de_24_xlarge,
    ml_p6_e_gb200_36_xlarge,
    ml_p5_4_xlarge,
    ml_p6_b300_48_xlarge,

    pub const json_field_names = .{
        .ml_p4_d_24_xlarge = "ML_P4D_24XLARGE",
        .ml_p5_48_xlarge = "ML_P5_48XLARGE",
        .ml_p5_e_48_xlarge = "ML_P5E_48XLARGE",
        .ml_p5_en_48_xlarge = "ML_P5EN_48XLARGE",
        .ml_trn1_32_xlarge = "ML_TRN1_32XLARGE",
        .ml_trn2_48_xlarge = "ML_TRN2_48XLARGE",
        .ml_p6_b200_48_xlarge = "ML_P6_B200_48XLARGE",
        .ml_p4_de_24_xlarge = "ML_P4DE_24XLARGE",
        .ml_p6_e_gb200_36_xlarge = "ML_P6E_GB200_36XLARGE",
        .ml_p5_4_xlarge = "ML_P5_4XLARGE",
        .ml_p6_b300_48_xlarge = "ML_P6_B300_48XLARGE",
    };
};
