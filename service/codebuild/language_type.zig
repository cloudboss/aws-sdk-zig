pub const LanguageType = enum {
    java,
    python,
    node_js,
    ruby,
    golang,
    docker,
    android,
    dotnet,
    base,
    php,

    pub const json_field_names = .{
        .java = "JAVA",
        .python = "PYTHON",
        .node_js = "NODE_JS",
        .ruby = "RUBY",
        .golang = "GOLANG",
        .docker = "DOCKER",
        .android = "ANDROID",
        .dotnet = "DOTNET",
        .base = "BASE",
        .php = "PHP",
    };
};
