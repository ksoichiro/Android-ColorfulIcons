package com.github.ksoichiro.androidcolorfulicons;

import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.MenuItem;
import android.widget.TextView;

public class AboutActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_about);

        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        ((TextView) findViewById(R.id.version_name)).setText(getVersionName());
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            finish();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private String getVersionName() {
        final PackageManager manager = getPackageManager();
        String versionName;
        try {
            final PackageInfo info = manager.getPackageInfo(
                    getPackageName(),
                    PackageManager.GET_META_DATA);
            versionName = info.versionName;
        } catch (PackageManager.NameNotFoundException e) {
            versionName = "";
        }
        return versionName;
    }
}
