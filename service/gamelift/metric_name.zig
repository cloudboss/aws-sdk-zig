pub const MetricName = enum {
    activating_game_sessions,
    active_game_sessions,
    active_instances,
    available_game_sessions,
    available_player_sessions,
    current_player_sessions,
    idle_instances,
    percent_available_game_sessions,
    percent_idle_instances,
    queue_depth,
    wait_time,
    concurrent_activatable_game_sessions,

    pub const json_field_names = .{
        .activating_game_sessions = "ActivatingGameSessions",
        .active_game_sessions = "ActiveGameSessions",
        .active_instances = "ActiveInstances",
        .available_game_sessions = "AvailableGameSessions",
        .available_player_sessions = "AvailablePlayerSessions",
        .current_player_sessions = "CurrentPlayerSessions",
        .idle_instances = "IdleInstances",
        .percent_available_game_sessions = "PercentAvailableGameSessions",
        .percent_idle_instances = "PercentIdleInstances",
        .queue_depth = "QueueDepth",
        .wait_time = "WaitTime",
        .concurrent_activatable_game_sessions = "ConcurrentActivatableGameSessions",
    };
};
