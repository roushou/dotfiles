# History inspection (requires sqlite history: `$env.config.history.file_format = "sqlite"`).

# What did I actually run today, and what failed?
export def today [] {
  let start_of_day = (date now | format date "%Y-%m-%d" | into datetime)
  history --long
  | where {|row| $row.start_timestamp? != null and ($row.start_timestamp | into datetime) > $start_of_day }
  | select start_timestamp command exit_status duration
}

# Most recent commands that exited non-zero.
export def lastfail [n: int = 10] {
  history --long
  | where {|r| $r.exit_status? != null and $r.exit_status != 0 }
  | select start_timestamp command exit_status
  | last $n
}
