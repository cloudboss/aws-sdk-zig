pub const GuardrailContentFilterType = enum {
    insults,
    hate,
    sexual,
    violence,
    misconduct,
    prompt_attack,

    pub const json_field_names = .{
        .insults = "INSULTS",
        .hate = "HATE",
        .sexual = "SEXUAL",
        .violence = "VIOLENCE",
        .misconduct = "MISCONDUCT",
        .prompt_attack = "PROMPT_ATTACK",
    };
};
