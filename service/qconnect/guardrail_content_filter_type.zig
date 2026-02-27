/// Type of text to text filter in content policy
pub const GuardrailContentFilterType = enum {
    sexual,
    violence,
    hate,
    insults,
    misconduct,
    prompt_attack,

    pub const json_field_names = .{
        .sexual = "SEXUAL",
        .violence = "VIOLENCE",
        .hate = "HATE",
        .insults = "INSULTS",
        .misconduct = "MISCONDUCT",
        .prompt_attack = "PROMPT_ATTACK",
    };
};
