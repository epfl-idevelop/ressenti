# Try it!

```
docker-compose up --build -d && docker-compose logs -f
```

Then wait a bit, and browse e.g. http://localhost:9090/graph?g0.range_input=1h&g0.expr=probe_duration_seconds&g0.tab=0
