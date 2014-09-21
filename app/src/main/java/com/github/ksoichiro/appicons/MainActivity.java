package com.github.ksoichiro.appicons;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        load();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                finish();
                return true;
            case R.id.action_about:
                startActivity(new Intent(this, AboutActivity.class));
                break;
        }
        return super.onOptionsItemSelected(item);
    }

    private void load() {
        List<Icon> icons = new ArrayList<Icon>();
        icons.add(new Icon(R.drawable.ic_action_clock, "ic_action_clock"));
        icons.add(new Icon(R.drawable.ic_action_comment, "ic_action_comment"));
        icons.add(new Icon(R.drawable.ic_action_download, "ic_action_download"));
        icons.add(new Icon(R.drawable.ic_action_edit, "ic_action_edit"));
        icons.add(new Icon(R.drawable.ic_action_friend, "ic_action_friend"));
        icons.add(new Icon(R.drawable.ic_action_fullscreen, "ic_action_fullscreen"));
        icons.add(new Icon(R.drawable.ic_action_help, "ic_action_help"));
        icons.add(new Icon(R.drawable.ic_action_history, "ic_action_history"));
        icons.add(new Icon(R.drawable.ic_action_next, "ic_action_next"));
        icons.add(new Icon(R.drawable.ic_action_overflow, "ic_action_overflow"));
        icons.add(new Icon(R.drawable.ic_action_prev, "ic_action_prev"));
        icons.add(new Icon(R.drawable.ic_action_reload, "ic_action_reload"));
        icons.add(new Icon(R.drawable.ic_action_settings, "ic_action_settings"));
        icons.add(new Icon(R.drawable.ic_action_tag, "ic_action_tag"));
        IconAdapter adapter = new IconAdapter(this, icons);
        ListView list = (ListView) findViewById(R.id.list);
        list.setAdapter(adapter);
    }
}

